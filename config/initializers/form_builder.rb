class ActionView::Helpers::FormBuilder
  def error_for(field)
    return unless object.errors.include?(field)

    content_tag :div, class: "mt-2 text-sm text-red-600" do
      object.errors[field].join(", ")
    end
  end
end