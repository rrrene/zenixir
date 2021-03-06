defmodule SeatchTest do
  use ExUnit.Case
  use Zendesk
  use TestHelper
  use ExVCR.Mock


  test "it perform a type search" do
    use_cassette "search_for_user" do
      res = Zendesk.account(subdomain: "your_subdomain",
      email: "test@zendesk.com", password: "test")
      |> search(type: :user, query: "Tags")

      assert length(res) == 1
      assert res |> hd |> Dict.get(:name) == "No Tags Agent"
    end
  end

  test "it perform a raw search" do
    use_cassette "search_for_ticket" do
      res = Zendesk.account(subdomain: "your_subdomain",
      email: "test@zendesk.com", password: "test")
      |> search(query: "type:ticket Ticket with Attachments")

      assert length(res) == 1
      assert res |> hd |> Dict.get(:subject) == "Ticket with Attachments (DO NOT SOLVE OR DELETE)"
    end
  end

end
