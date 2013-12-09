# coding: utf-8
class Cpanel::Bbs::NodesController < Cpanel::ApplicationController

  def index
    @nodes = ::Bbs::Node.sorted
  end

  def show
    @node = ::Bbs::Node.find(params[:id])
  end

  def new
    @node = ::Bbs::Node.new
  end

  def edit
    @node = ::Bbs::Node.find(params[:id])
  end

  def create
    @node = Bbs::Node.new(params[:bbs_node].permit!)

    if @node.save
      redirect_to(cpanel_bbs_nodes_path, :notice => 'Bbs::Node was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @node = Bbs::Node.find(params[:id])

    if @node.update_attributes(params[:bbs_node].permit!)
      redirect_to(cpanel_bbs_nodes_path, :notice => 'Bbs::Node was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @node = Bbs::Node.find(params[:id])
    @node.destroy

    redirect_to(cpanel_nodes_url)
  end
end
