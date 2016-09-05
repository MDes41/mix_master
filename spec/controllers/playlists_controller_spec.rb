require 'rails_helper'

RSpec.describe PlaylistsController, type: :controller do
  describe "POST #create" do
    context "with valid params" do
      it "adds to the playlist count" do
        expect {
          post :create, {:playlist => attributes_for(:playlist) }
        }.to change(Playlist, :count).by(1)
      end

      it "create a playlist object" do
        post :create, {:playlist => attributes_for(:playlist)}
        expect(assigns(:playlist)).to be_a(Playlist)
        expect(assigns(:playlist)).to be_persisted
      end

      it "redirect to playlists path" do
        post :create, {:playlist => attributes_for(:playlist)}
        expect(response).to redirect_to(Playlist.last)
      end
    end

    context "with invalid params" do
      it "assigns playlist to @playlist" do
        post :create, {:playlist => attributes_for(:playlist, name: nil)}
        expect(assigns(:playlist)).to be_a_new(Playlist)
      end

      it "re-renders the 'new' template" do
        post :create, {:playlist => attributes_for(:playlist, name: nil)}
        expect(response).to render_template('new')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      it "assigns to playlist with givin playlist params" do
        playlist = create(:playlist)
        put :update, {:id => playlist.to_param, :playlist => attributes_for(:playlist, name: "New name")}
        playlist.reload
        expect(playlist.name).to eq("New name")
      end

      it "assigns the requested artist to @artist" do
        playlist = create(:playlist)
        put :update, {:id => playlist.to_param, :playlist => attributes_for(:playlist, name: "New name")}
        expect(assigns(:playlist)).to eq(playlist)
      end
    end

    context "with invalid parmas" do
      it "it assigns the playlist to @playlist" do
        playlist = create(:playlist)
        put :update, {:id => playlist.to_param, :playlist => attributes_for(:playlist, name: nil)}
        expect(assigns(:playlist)).to eq(playlist)
      end

      it "re-renders the edit template" do
        playlist = create(:playlist)
        put :update, {:id => playlist.to_param, :playlist => attributes_for(:playlist, name: nil)}
        expect(response).to render_template("edit")
      end
    end
  end
end
