module ApplicationHelper
  include Pagy::Frontend

  def number_to_euro(number)
    if number.eql?(0)
      "Gratuit"
    else
      number_to_currency(number, locale: :fr, precision: 2, unit: "€", separator: ",", delimiter: " ", format: "%n %u")
    end
  end

  def turbo_native_app?
    request.user_agent.to_s.match?(/Turbo Native/)
  end
end
