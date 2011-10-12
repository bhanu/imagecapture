require 'rho/rhocontroller'
require 'helpers/browser_helper'

class ImageController < Rho::RhoController
  include BrowserHelper

  # GET /Image
  def index
    @images = Image.find(:all)
    render :back => '/app'
  end

  # GET /Image/new
  def new
    # Same as Camera::take_picture('/app/model/camera_callback')
    Camera::take_picture(url_for :action => :camera_callback)
    ""
  end

  def edit
    # Same as Camera::choose_picture('/app/model/camera_callback')
    Camera::choose_picture(url_for :action => :camera_callback)
    ""
  end

  def camera_callback
    if @params['status'] == 'ok'
      image = Image.new({'image_uri' => @params['image_uri']})
      image.save
    end

    WebView.navigate(url_for :action => :index)
    ""
  end

  # POST /Image/{1}/delete
  def delete
    puts "## In delete, @params; #{@params.inspect}"
    @image = Image.find(@params['id'])
    puts "## In delete, @image: #{@image.inspect}"
    @image.destroy if @image
    redirect :action => :index  
  end
end
