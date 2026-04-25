apartment_params =
  [
    { number: '1', prefix: '', name: 'Петрова З.А.', area: 36.6 },
    { number: '2', prefix: '', name: '', fragmented: true, area: 72.6 },
    { number: '2', prefix: '1', name: 'Сидорова', area: 36.0, parent: '2' },
    { number: '2', prefix: '2', name: 'Качкова', area: 36.6, parent: '2' },
    { number: '3', prefix: '', name: '', fragmented: true, area: 72.6 },
    { number: '3', prefix: '1', name: 'Сидорова 3', area: 36.0, parent: '3' },
    { number: '3', prefix: '2', name: 'Качкова 3', area: 36.0, parent: '3' }
  ]

apartment_params.each do |params|
  Apartment.find_or_create_by(number: params[:number], prefix: params[:prefix]) do |apartment|
    apartment.name = params[:name]
    apartment.area = params[:area]
    apartment.fragmented = params[:fragmented] if params[:fragmented]
    apartment.parent_apartment = Apartment.find_by(number: params[:parent], fragmented: true) if params[:parent]
  end
end
