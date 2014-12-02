enable :sessions

get '/deck/:d_id' do
  session[:deck_id] = params[:d_id]
  redirect to ('/play')
end

get '/play' do
  @cards = Card.where(deck_id:session[:deck_id]).sample(10)
  erb :play
end

post '/answer' do
  @correct = 0
  p session[:desk_id]
  p session[:user_id]
  r = Round.create(deck_id:session[:deck_id],user_id:session[:user_id])
  k = params.keys
  k.each do |v|
    c = Card.find(v.to_i)
    if params[v] == c.answer
      @correct += 1
      g = Guess.create(round_id:r.id,card_id:c.id,correctness:'correct')
    else
      g = Guess.create(round_id:r.id,card_id:c.id,correctness:'wrong')
    end
  end
  r.score = @correct
  r.save
  erb :score
end