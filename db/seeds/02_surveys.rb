survey_params =
  [
    { name: 'Test', description: '' },
    { name: 'Опрос номер первый', description: 'Самый первый опрос, он самый важный' },
  ]

survey_params.each do |params|
  Survey.find_or_create_by(name: params[:name], description: params[:description])
end