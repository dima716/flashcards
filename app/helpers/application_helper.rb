module ApplicationHelper
  def flash_class(level)
    case level
    when "info" then "alert alert-info"
    when "success", "empty", "reviewed" then "alert alert-success"
    when "error" then "alert alert-danger"
    end
  end
end
