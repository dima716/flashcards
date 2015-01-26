module ApplicationHelper
  def flash_class(level)
    case level
    when "info" then "alert alert-info"
    when "success" then "alert alert-success"
    when "error", "empty", "reviewed" then "alert alert-danger"
    end
  end
end
