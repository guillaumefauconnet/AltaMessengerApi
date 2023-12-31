defmodule Altamessengerapi.MessengerTest do
  use Altamessengerapi.DataCase

  alias Altamessengerapi.Messenger

  describe "channels" do
    alias Altamessengerapi.Messenger.Channel

    import Altamessengerapi.MessengerFixtures

    @invalid_attrs %{name: nil}

    test "list_channels/0 returns all channels" do
      channel = channel_fixture()
      assert Messenger.list_channels() == [channel]
    end

    test "get_channel!/1 returns the channel with given id" do
      channel = channel_fixture()
      assert Messenger.get_channel!(channel.id) == channel
    end

    test "create_channel/1 with valid data creates a channel" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Channel{} = channel} = Messenger.create_channel(valid_attrs)
      assert channel.name == "some name"
    end

    test "create_channel/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Messenger.create_channel(@invalid_attrs)
    end

    test "update_channel/2 with valid data updates the channel" do
      channel = channel_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Channel{} = channel} = Messenger.update_channel(channel, update_attrs)
      assert channel.name == "some updated name"
    end

    test "update_channel/2 with invalid data returns error changeset" do
      channel = channel_fixture()
      assert {:error, %Ecto.Changeset{}} = Messenger.update_channel(channel, @invalid_attrs)
      assert channel == Messenger.get_channel!(channel.id)
    end

    test "delete_channel/1 deletes the channel" do
      channel = channel_fixture()
      assert {:ok, %Channel{}} = Messenger.delete_channel(channel)
      assert_raise Ecto.NoResultsError, fn -> Messenger.get_channel!(channel.id) end
    end

    test "change_channel/1 returns a channel changeset" do
      channel = channel_fixture()
      assert %Ecto.Changeset{} = Messenger.change_channel(channel)
    end
  end

  describe "messages" do
    alias Altamessengerapi.Messenger.Message

    import Altamessengerapi.MessengerFixtures

    @invalid_attrs %{message: nil}

    test "list_messages/0 returns all messages" do
      message = message_fixture()
      assert Messenger.list_messages() == [message]
    end

    test "get_message!/1 returns the message with given id" do
      message = message_fixture()
      assert Messenger.get_message!(message.id) == message
    end

    test "create_message/1 with valid data creates a message" do
      user = Altamessengerapi.AccountsFixtures.user_fixture()
      channel = Altamessengerapi.MessengerFixtures.channel_fixture()

      valid_attrs = %{message: "some message", channel_id: channel.id, user_id: user.id}

      assert {:ok, %Message{} = message} = Messenger.create_message(valid_attrs)
      assert message.message == "some message"
    end

    test "create_message/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Messenger.create_message(@invalid_attrs)
    end

    test "update_message/2 with valid data updates the message" do
      message = message_fixture()
      update_attrs = %{message: "some updated message"}

      assert {:ok, %Message{} = message} = Messenger.update_message(message, update_attrs)
      assert message.message == "some updated message"
    end

    test "update_message/2 with invalid data returns error changeset" do
      message = message_fixture()
      assert {:error, %Ecto.Changeset{}} = Messenger.update_message(message, @invalid_attrs)
      assert message == Messenger.get_message!(message.id)
    end

    test "delete_message/1 deletes the message" do
      message = message_fixture()
      assert {:ok, %Message{}} = Messenger.delete_message(message)
      assert_raise Ecto.NoResultsError, fn -> Messenger.get_message!(message.id) end
    end

    test "change_message/1 returns a message changeset" do
      message = message_fixture()
      assert %Ecto.Changeset{} = Messenger.change_message(message)
    end
  end
end
