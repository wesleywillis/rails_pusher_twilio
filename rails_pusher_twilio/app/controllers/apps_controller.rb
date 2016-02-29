class AppsController < ApplicationController
  before_action :set_app, only: [:show, :update, :destroy]

  # GET /apps
  # GET /apps.json
  set :public_folder, Proc.new { File.join(root, "public") }

  config = YAML.load_file('./config.yml')

  Pusher.app_id = config['pusher']['app_id']
  Pusher.key = config['pusher']['app_key']
  Pusher.secret = config['pusher']['app_secret']

  def index
    @apps = App.all
    @app_key = config['pusher']['app_key']

    render json: @apps
  end

  def call
    if( params['AccountSid'] != config['twilio']['account_sid'] )
    status 401
  else
    Pusher['calls'].trigger('call_incoming', {
      :from_number =>  '...' + params['From'][-4, 4],
      :timestamp => Time.now.strftime("%Y-%m-%dT%H:%M:%S")
    })
    end
  end

  def sms
    if( params['AccountSid'] != config['twilio']['account_sid'] )
      status 401
    else
      Pusher['sms'].trigger('sms_received', {
        :from_number => '...' + params['From'][-4, 4],
        :timestamp => Time.now.strftime("%Y-%m-%dT%H:%M:%S"),
        :text => params['Body']
        })
    end
  end

  # GET /apps/1
  # GET /apps/1.json
  def show
    render json: @app
  end

  # POST /apps
  # POST /apps.json
  def create
    @app = App.new(app_params)

    if @app.save
      render json: @app, status: :created, location: @app
    else
      render json: @app.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /apps/1
  # PATCH/PUT /apps/1.json
  def update
    @app = App.find(params[:id])

    if @app.update(app_params)
      head :no_content
    else
      render json: @app.errors, status: :unprocessable_entity
    end
  end

  # DELETE /apps/1
  # DELETE /apps/1.json
  def destroy
    @app.destroy

    head :no_content
  end

  private

    def set_app
      @app = App.find(params[:id])
    end

    def app_params
      params.require(:app).permit(:from_number, :timestamp, :text)
    end
end
