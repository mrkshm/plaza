module ApplicationHelper
  def title
    content_for?(:title) ? "#{content_for(:title)} | #{t('plaza')}" : t("plaza")
  end

  def daisy_alert_level(level)
    {
      notice: "info",
      info: "info",
      success: "success",
      alert: "warning",
      warning: "warning",
      error: "error"
    }[level.to_sym] || "info"
  end
end
