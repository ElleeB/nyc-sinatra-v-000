class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all

    erb :'figures/index'
  end

  post '/figures' do #create

    @title = params[:title]
    @title_ids = params[:figure][:title_ids]
    @landmark = params[:landmark]
    @landmark_ids = params[:figure][:landmark_ids]

    @figure = Figure.new(name: params[:figure][:name])

    if !@title[:name].empty?
      title = Title.create(name: @title[:name])
      @figure.titles << title

    elsif @title_ids
      @title_ids.each do |id|
        title = Title.find_by_id(id)
        @figure.titles << title
        @figure.titles.uniq
      end
    end

    if !@landmark[:name].empty?
      landmark = Landmark.create(name: @landmark[:name])
      @figure.landmarks << landmark

    elsif @landmark_ids
      @landmark_ids.each do |id|
        landmark = Landmark.find_by_id(id)
        @figure.landmarks << landmark
        @figure.landmarks.uniq
      end
    end

    @figure.save

    redirect to "/figures/#{@figure.id}"
  end

  get '/figures/new' do #new

    erb :'figures/new'
  end

  get '/figures/:id' do #show
    @figure = Figure.find_by_id(params[:id])

    erb :'figures/show'
  end

  get '/figures/:id/edit' do #edit
    @figure = Figure.find_by_id(params[:id])

    erb :'figures/edit'
  end

  patch '/figures/:id' do #update
    @figure = Figure.find_by_id(params[:id])

    @title = params[:title]
    @title_ids = params[:figure][:title_ids]
    @landmark = params[:landmark]
    @landmark_ids = params[:figure][:landmark_ids]

    @figure.name = params[:figure][:name]

    if !@title[:name].empty?
      title = Title.create(name: @title[:name])
      @figure.titles << title

    elsif @title_ids
      @title_ids.each do |id|
        title = Title.find_by_id(id)
        @figure.titles << title
        @figure.titles.uniq
      end
    end

    if !@landmark[:name].empty?
      landmark = Landmark.create(name: @landmark[:name])
      @figure.landmarks << landmark

    elsif @landmark_ids
      @landmark_ids.each do |id|
        landmark = Landmark.find_by_id(id)
        @figure.landmarks << landmark
        @figure.titles.uniq
      end
    end

    @figure.save

    redirect to "/figures/#{@figure.id}"
  end
end

# New Title/Landmark params => {"figure"=>{"name"=>"Tyrion"}, "title"=>{"name"=>"The Hand"}, "landmark"=>{"name"=>"Casterly Rock"}}
# Checked Title/Landmark params => {"figure"=>{"name"=>"Tyrion", "title_ids"=>["3"], "landmark_ids"=>["9"]}, "title"=>{"name"=>""}, "landmark"=>{"name"=>""}}
