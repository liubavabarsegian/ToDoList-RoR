json.extract! task, :id, :title, :description, :due, :reminder, :reminder_time, :completed, :created_at, :updated_at
json.url task_url(task, format: :json)
