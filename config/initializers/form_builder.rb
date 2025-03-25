class ActionView::Helpers::FormBuilder
  def error_for(field)
    return unless object.errors.where(field: field).any?

    content_tag :div, class: "mt-2 text-sm text-red-600" do
      object.errors[field].to_sentence
    end
  end
end
