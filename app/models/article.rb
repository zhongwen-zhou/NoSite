# coding: utf-8
# 单页的文档页面
# 采用 Markdown 编写
require "redcarpet"
class Article
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel
  include Mongoid::SoftDelete

  # 页面地址
  field :title
  # 原始 Markdown 内容
  field :content
  # Markdown 格式化后的 html
  field :content_html
  field :editor_names, :type => Array, :default => []
  field :locked, :type => Mongoid::Boolean, :default => false
  field :comments_count, :type => Integer, :default => 0

  attr_accessor :user_id, :change_desc, :version_enable

  validates_presence_of :title, :content

  # before_save :markdown_for_body_html
  def markdown_for_body_html
    return true if not self.body_changed?

    self.body_html = MarkdownConverter.convert(self.body)
  rescue => e
    Rails.logger.error("markdown_for_body_html failed: #{e}")
  end

  # before_save :append_editor
  def append_editor
    if not self.editor_ids.include?(self.user_id.to_i)
      self.editor_ids << self.user_id.to_i
    end
  end

  # 记录更新版本
  # after_save :create_version
  def create_version
    # 只有当 version_enable 为 true 的时候才记录版本
    # 以免后台，以及其他的一些 update 时被误调用
    return true if not self.version_enable
    # 只有 body, title, slug 更改了才更新版本
    if self.body_changed? or self.title_changed? or self.slug_changed?
      self.inc(version: 1)
      PageVersion.create(:user_id => self.user_id,
                         :page_id => self.id,
                         :desc => self.change_desc,
                         :version => self.version,
                         :body => self.body,
                         :title => self.title,
                         :slug => self.slug)
    end
  end

  # 撤掉到指定版本
  def revert_version(version)
    page_version = PageVersion.where(:page_id => self.id, :version => version).first
    return false if page_version.blank?
    self.update_attributes(:body => page_version.body,
                           :title => page_version.title,
                           :slug => page_version.slug)
  end

  def editors
    User.where(:_id.in => self.editor_ids)
  end

  def self.find_by_slug(slug)
    where(:slug => slug).first
  end
end
