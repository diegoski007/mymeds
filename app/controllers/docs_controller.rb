class DocsController < ApplicationController
  before_action :set_doc, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /docs
  # GET /docs.json
  def index
    @docs = Doc.where(user_id: current_user.id).order(created_at: :desc)
    @medictasks = Medictask.where(user_id: current_user.id)
    @doc = Doc.new
    @docs = @docs.where("title like ?", "%#{params[:q]}%") if params[:q]
  end

  # GET /docs/1
  # GET /docs/1.json
  def show
  end

  # GET /docs/new
  def new
    @doc = Doc.new
  end

  # GET /docs/1/edit
  def edit
  end

  # POST /docs
  # POST /docs.json
  def create
    @doc = Doc.new(doc_params)
    @doc.user_id = current_user.id

    respond_to do |format|
      if @doc.save
        format.html { redirect_to @docs, notice: 'Doc was successfully created.' }
        format.json { render :index, status: :created, location: @docs }
        format.js { redirect_to root_path, notice: 'Doc was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @doc.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /docs/1
  # PATCH/PUT /docs/1.json
  def update
    respond_to do |format|
      if @doc.update(doc_params)
        format.html { redirect_to @doc, notice: 'Doc was successfully updated.' }
        format.json { render :show, status: :ok, location: @doc }
        format.js { redirect_to root_path, notice: 'Doc was successfully created.' }

      else
        format.html { render :edit }
        format.json { render json: @doc.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /docs/1
  # DELETE /docs/1.json
  def destroy
    @doc.destroy
    respond_to do |format|
      format.html { redirect_to docs_url, notice: 'Doc was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_doc
      @doc = Doc.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def doc_params
      params.require(:doc).permit(:title, :content, :image)
    end
end
