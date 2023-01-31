json.extract! activity, :id, :duration_in_minutes, :gender, :level, :maximum_participants_number, :participants_count, :per_participant_price_cents, :starts_at, :sport_id, :created_at, :updated_at
json.url activity_url(activity, format: :json)
