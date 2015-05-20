require 'net/http'

class TwittersController < ApplicationController

  def get_token

    client = TwitterOAuth::Client.new(
        :consumer_key => 'BN14oi6siiCwG2qXDgEcfXpI4',
        :consumer_secret => 'qsccXWEEQPtOKErQcGCsK22L0zhgHpKFRpOI0PhF749SuK8NWm'
    )

    #request_token = client.authentication_request_token(:oauth_callback => "http://192.168.10.112:8383/HTML5Application/index.html#config")

    request_token = client.request_token(:oauth_callback => params[:callback])

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

    #client = TwitterOAuth::Client.new(
        #:consumer_key => params[:con_key],
        #:consumer_secret => params[:con_secret],
        #:token => params[:acc_key],
        #:secret => params[:acc_secret]

    #)
    #client.update(params[:message])


    #Twitter.configure do |config|
      #config.consumer_key = params[:con_key]
      #config.consumer_secret = params[:con_secret]
      #config.oauth_token = params[:acc_key]
      #config.oauth_token_secret =  params[:acc_secret]
      #end

    twitter = Twitter::REST::Client.new do |config|
      config.consumer_key = params[:con_key]
      config.consumer_secret = params[:con_secret]
      config.access_token = params[:acc_key]
      config.access_token_secret = params[:acc_secret]
    end

    #Twitter.update("I'm tweeting with @gem!")

    twitter.update("@BenMorganIO taught me how to tweet with the Twitter API!")

    respond_to do |format|
    #  format.html
      format.json
    end
  end


end
