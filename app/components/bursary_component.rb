# frozen_string_literal: true

class BursaryComponent < ViewComponent::Base
  include ViewComponent::Translatable

  def initialize(
    text: nil,
    tracking_event_category: nil,
    tracking_event_label: nil,
    bottom_margin: true,
    class_name: nil
  )
    @text = text
    @tracking_event_category = tracking_event_category
    @tracking_event_label = tracking_event_label
    @bottom_margin = bottom_margin
    @class_name = class_name
  end

  def tracking_data
    return nil unless @tracking_event_category.present? &&
                      @tracking_event_label.present?

    {
      event_action: 'click',
      event_category: @tracking_event_category,
      event_label: @tracking_event_label
    }
  end
end
