class LinksController < ApplicationController
before_action :authenticate_user! 

  def new
     @link = Link.new

  end
#---------------------------------------------------------------
# metodo create con alertas de creación (success && failure)

  def create
    @link = Link.new(link_params)
#--------------------------------------------------------------

    if @link.save
      flash[:notice] = 'EL lost ha sido creado con éxito'
      redirect_to links_path
    else
      flash[:alert] = 'tu Link no ha sido creado con exito'
      render :new
    end
#-----------------------------------------
  end
#-------------------------------------------------------------
  def edit
     @link = Link.find(params[:id])
  end

  def update
    @link = Link.find(params[:id])

     if   @link.update(link_params)
      flash.notice = "link '#{@link.title}' Updated!"
      redirect_to link_path(@link)
    else
      flash.alert = "sometihing it is not right with the link '#{@link}'"
    end

  end

  def destroy
    @link = Link.delete(params[:id])
     flash[:notice] = "the Link #{@link} it is no longer avaliable."
    redirect_to links_path
  end

  def show
     @link = Link.find(params[:id])

     @Link = Link.new

  end

  def index
    @links = Link.all
  end



private


#-------------------------------------------------------------------------
#method that ask for the admin user_signed_in.
  def is_admin?
    unless current_user.admin?
          flash[:alert] = 'you can not access this rute'
          redirect_to root_path
        end
      end

  #---------------------------------------------------------------------------------------------------
    def link_params #Seguridad para que el usuario no pueda enviar más información de la requerida
        params.require(:link).permit(:title, :description, :category, :url )
    end
#------------------------------------------------------------------------------------------------------
end
