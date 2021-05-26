# frozen_string_literal: true

class BursaryComponent < ViewComponent::Base
  def initialize(tracking_event_category: nil, tracking_event_label: nil)
    @tracking_event_category = tracking_event_category
    @tracking_event_label = tracking_event_label
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
