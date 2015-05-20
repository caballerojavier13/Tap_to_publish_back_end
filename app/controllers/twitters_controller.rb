require 'net/http'

class TwittersController < ApplicationController

  def get_token

    client = TwitterOAuth::Client.new(
        :consumer_key => 'BN14oi6siiCwG2qXDgEcfXpI4',
        :consumer_secret => 'qsccXWEEQPtOKErQcGCsK22L0zhgHpKFRpOI0PhF749SuK8NWm'
    )

    request_token = client.authentication_request_token(:oauth_callback => params[:callback])

    #request_token = client.request_token(:oauth_callback => params[:callback])

    @Data  = {:token => request_token.token, :secret => request_token.secret, :url => request_token.authorize_url, :status => "200"}.to_json


    respond_to do |format|
      format.json {render json: @Data}
    end

  end


  def validate_token
    client = TwitterOAuth::Client.new(
        :consumer_key => 'BN14oi6siiCwG2qXDgEcfXpI4',
        :consumer_secret => 'qsccXWEEQPtOKErQcGCsK22L0zhgHpKFRpOI0PhF749SuK8NWm'
    )

    access_token = client.authorize(
      params[:oauth_token],
      params[:oauth_secret],
      :oauth_verifier => params[:oauth_verifier]
    )

    @Data  = {:token => access_token, :status => "200"}

    respond_to do |format|
      format.json {render json: @Data}
    end

  end


  def publish

    client = TwitterOAuth::Client.new(
        :consumer_key => params[:con_key],
        :consumer_secret => params[:con_secret],
        :token => params[:userKey],
        :secret => params[:userSecret]
    )

    client.update(params[:message])

    respond_to do |format|
      #format.html
      format.json {render json: {:status => "200"}}
    end
  end

  def get_info_user

    client = TwitterOAuth::Client.new(
        :consumer_key => params[:con_key],
        :consumer_secret => params[:con_secret],
        :token => params[:userKey],
        :secret => params[:userSecret]
    )


    respond_to do |format|
      #format.html
      format.json {render json: client.user}
    end
  end


end
