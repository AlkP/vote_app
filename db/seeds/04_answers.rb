answer_params =
  [
    { number: '2', prefix: '1', question: 'Самый первый вопрос', vote: :yes },
    { number: '2', prefix: '1', question: 'Самый важный вопрос', vote: :yes },
    { number: '2', prefix: '2', question: 'Самый важный вопрос', vote: :no },
    { number: '3', prefix: '2', question: 'Самый важный вопрос', vote: :neutral },
  ]

answer_params.each do |params|
  apartment = Apartment.by_number(params[:number]).by_prefix(params[:prefix]).take
  question = Question.by_name(params[:question]).take
  Answer.find_or_create_by(apartment: apartment, question: question) do |answer|
    answer.vote = params[:vote]
  end
end