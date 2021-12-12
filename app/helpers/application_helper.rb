module ApplicationHelper
  def create_time(created_at)
    created_at.strftime("%Y年%m月%d日")
  end
  
  def update_time(updated_at)
    updated_at.strftime("%Y年%m月%d日")
  end
end
