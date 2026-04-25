question_params =
  [
    { name: 'Test', survey_name: 'Test' },
    { name: 'Самый первый вопрос', survey_name: 'Опрос номер первый' },
    { name: 'Самый важный вопрос', survey_name: 'Опрос номер первый' }
  ]

question_params.each do |params|
  Question.find_or_create_by(name: params[:name], survey: Survey.find_by(name: params[:survey_name]))
end
