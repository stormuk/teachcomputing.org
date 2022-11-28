module ResponsiveHelpers
  def resize_window_to_mobile
    resize_window_by([640, 320])
  end

  def resize_window_to_tablet
    resize_window_by([960, 641])
  end

  def resize_window_to_desktop
    resize_window_by([1024, 769])
  end

  private

    def resize_window_by(size)
      Capybara.page.current_window.resize_to(size[0], size[1])
    end
end
