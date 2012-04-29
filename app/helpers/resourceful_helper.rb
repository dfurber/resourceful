module ResourcefulHelper
  
  def parse_panel_tree(attributes)
    panels = []
    current_panel = nil
    attributes.each do |attribute|
      if attribute.is_a?(Resourceful::Panel)
        if current_panel
          panels << current_panel 
          current_panel = nil
        end
        panels << attribute
      elsif attribute[:as] == :tab
        if current_panel
          panels << current_panel
          current_panel = nil
        end
        panels << Resourceful::Tab.new(attribute)
      else
        current_panel = Resourceful::Panel.new(:full) unless current_panel
        current_panel.show attribute.delete(:name), attribute
      end
    end
    panels << current_panel if current_panel
    panels
  end

  def render_attribute(model, options)
    
    options = model if model.is_a?(Hash)
    
    if_statement = options[:if]
    if if_statement.is_a?(Proc)
      return unless if_statement.call(controller)
    end
    unless_statement = options[:unless]
    if unless_statement.is_a?(Proc)
      return if unless_statement.call(controller)
    end

    return render_nested_attributes(model, options) if options[:with]
    
    case options[:as]
    when :tab
      render options[:tab]
    when :cell
      options.delete :as
      display  = options.delete(:display) || :display
      label    = options.delete(:label)
      contents = render_cell options[:name], display, options.merge(:model => model)
      if label
        content_tag :dl, "#{content_tag(:dt, label_for_attribute(options))}#{content_tag(:dd, contents)}".html_safe
      else
        contents
      end
    else
      if options[:args] and options[:args] == :model
        value = model
      else
        value = model.send options[:name]
      end

      value = if options[:formatter]
        if options[:formatter].is_a? Symbol
          send options[:formatter], value
        else
          options[:formatter].call value
        end
      else
        value
      end
      
      if options.delete(:hide_label)
        value
      else
        label = label_for_attribute options
        content_tag :dl, "#{content_tag(:dt, label_for_attribute(options))}#{content_tag(:dd, value)}".html_safe
      end
      
    end
      
  end
  
  def label_for_attribute(attribute)
    if attribute[:with]
      attribute[:with].new.show_title
    else
      attribute[:label] || attribute[:name].to_s.humanize.titleize
    end
  end
  
  def render_nested_attributes(model, options)
    renderer = options[:with].new
    case renderer.show_style
    when :short
      render 'nested_member_short', :model => model, :renderer => renderer, :name => options[:name]
    else
    end
  end
  
  def render_input(form, in_options)
    options = in_options.dup
    name = options[:name]
    if_statement = options[:if]
    if if_statement.is_a?(Proc)
      return unless if_statement.call(form.object)
    end
    unless_statement = options[:unless]
    
    return if unless_statement.is_a?(Proc) and unless_statement.call(form.object)

    on_action = options[:on]
    return if on_action and not on_action_condition_met?(on_action)
    options[:collection] = options[:collection].call(form, controller) if options[:collection].is_a?(Proc)
    case options[:as]
    when :fieldset
      render_fieldset form, options[:fieldset]
    when :legend
      content_tag :h3, options[:label]
    when :nested
      options.delete :as
      render_nested_form form, name, options
    when :cell
      options.delete :as
      display = options[:display] || :form
      render_cell name, display, options.merge(form: form, model: form.object)
    when :partial
      render name.to_s, form: form
    when :association
      options.delete :as
      form.association name, options
    else
      form.input name, options
    end
  end
  
  def on_action_condition_met?(on_action)
    (on_action == 'edit' and %w{edit update}.include?(params[:action])) or (on_action == 'new' and %w{new create}.include?(params[:action])) or (on_action == params[:action])
  end
  
  def tabs_to_render(tabs_to_show)
    tabs_to_show.inject([['Details', 'resource_details']]) {|a,tab| a << [tab[:label] || tab[:tab].to_s.titleize, tab[:tab]]}
  end
  
  def render_fieldset(form, panel)
    render 'fieldset', :form => form, :inputs => panel.inputs, :side => panel.side
  end
  
  def render_nested_form(form, name, options)

    source = options[:form].new
    if source.show_blank?
      form.object.send(name).build
    end
    
    render '/application/nested_form', :form => form, 
                          :name => name,
                          :title => source.title,
                          :class_name => source.class_name,
                          :inputs => source.inputs,
                          :allow_destroy => source.allow_destroy?,
                          :remove_label => source.remove_label,
                          :add_child_link_text => source.add_child_link_text

  end
  
  def add_child_link(name, f, method)
    fields = new_child_fields(f, method)
    link_to_function(name, "insert_fields(this, \"#{method}\", \"#{escape_javascript(fields)}\")".html_safe, :class => "btn")
  end
  
  def new_child_fields(form_builder, method, options = {})
    options[:object] ||= form_builder.object.class.reflect_on_association(method).klass.new
    options[:partial] ||= 'base/' + method.to_s.singularize
    options[:form_builder_local] ||= :form
    form_builder.fields_for(method, options[:object], :child_index => "new_#{method}") do |f|
      render(:partial => options[:partial], :locals => { options[:form_builder_local] => f })
    end
  end

  # Makes the TH of a column sortable. 
  def sort_column(column, title, options = {})
    if params[:sort_order]
      c = params[:sort_order][:c]
      d = params[:sort_order][:d]
    else
      c = controller.default_sort_column
      d = controller.default_sort_direction
    end
    condition = options[:unless] if options.has_key?(:unless)
    sort_dir = d == 'up' ? 'down' : 'up'
    link_class = (d == 'up' ? 'headerSortDown' : 'headerSortUp') if c == column.to_s
    html = []
    html << "<th class=\"header #{link_class}\">"
    html << link_to_unless(condition, title, request.parameters.merge( :sort_order => {:c => column, :d => sort_dir}))
    html << "</th>"
    html.join('').html_safe
  end
  
  def set_page_title(title)
    @page_title = title
  end

  def page_title
    @page_title || generate_page_title
  end

  def generate_page_title
    case params[:controller]
    when 'devise/sessions'
      nil
    else
      nil
    end
  end
  
  def set_browser_title(value)
    @browser_title = value
  end

  def browser_title
    title = @browser_title || page_title
    "#{title ? "#{title} | " : nil}#{AppConfig.site_title}"
  end
  
  def menu_divider
    content_tag(:li, '', :class => :divider)
  end
  
  def render_toolbar(tabs)
    tabs.inject('') do |html, tab|
      if tab == 'divider'
        html << menu_divider
      else
        name = tab[0]
        url = tab[1]
        url = send(url) if url.is_a?(Symbol)
        html_options = {}
        if params[:controller] == name.downcase
          html_options[:class] = 'active'
        end
        html << content_tag(:li, link_to(name, url).html_safe, html_options)
      end
    end
  end

  def dropdown_menu(name, items)
    name = "#{name}<b class=\"caret\"></b>".html_safe
    content_tag(:li, link_to(name, '#', :class => 'dropdown-toggle') + content_tag(:ul, items.html_safe, :class => 'dropdown-menu'), :class => :dropdown)
  end
  
  def renderable_columns
    cols = []
    controller.columns.each do |options|
      if_statement = options.delete :if
      if if_statement.is_a?(Proc)
        next unless if_statement.call(controller)
      end
      unless_statement = options.delete :unless
      if unless_statement.is_a?(Proc)
        next if unless_statement.call(controller)
      end
      cols << options
    end
    cols
  end
  
  def error_messages_for(object, message=nil)
    html = ""
    unless object.errors.blank?
      html << "<div class='formErrors #{object.class.name.humanize.downcase}Errors'>\n"
      if message.blank?
        if object.new_record?
          html << "\t\t<h5>There was a problem creating the #{object.class.name.humanize.downcase}</h5>\n"
        else
          html << "\t\t<h5>There was a problem updating the #{object.class.name.humanize.downcase}</h5>\n"
        end    
      else
        html << "<h5>#{message}</h5>"
      end  
      html << "\t\t<ul>\n"
      object.errors.full_messages.each do |error|
        html << "\t\t\t<li>#{error}</li>\n"
      end
      html << "\t\t</ul>\n"
      html << "\t</div>\n"
    end
    html
  end
    
end