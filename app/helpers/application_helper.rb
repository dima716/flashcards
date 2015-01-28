module ApplicationHelper
  def flash_class(level)
    case level
    when "info", "empty" then "alert alert-info"
    when "success", "reviewed" then "alert alert-success"
    when "error" then "alert alert-danger"
    end
  end
end
