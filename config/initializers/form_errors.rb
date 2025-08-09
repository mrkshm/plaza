ActionView::Base.field_error_proc = proc do |html_tag, instance|
  # Render a partial to display the form errors.
  # This is the idiomatic Rails way, separating logic from presentation.
  ApplicationController.renderer.render(
    partial: "application/form_errors",
    locals: { html_tag: html_tag, instance: instance }
  ).html_safe
end
