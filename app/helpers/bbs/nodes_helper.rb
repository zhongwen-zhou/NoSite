# coding: utf-8
module Bbs::NodesHelper
  def render_node_summary(node)
    content_tag(:p, node.summary, :class => "summary")
  end
end
