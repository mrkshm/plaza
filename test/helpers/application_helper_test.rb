require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  test "formats page specific title" do
    content_for(:title) { "Page Title" }

    assert_equal "Page Title | #{I18n.t("plaza")}", title
  end

  test "returns app name when no title presen" do
    assert_equal I18n.t("plaza"), title
  end
end
