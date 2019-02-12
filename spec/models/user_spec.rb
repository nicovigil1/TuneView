require "rails_helper" 

describe User do
  context "validations & attributes" do
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_presence_of(:uid) }
    it { should validate_presence_of(:spotify_token) }
    it { should validate_presence_of(:profile_url) }

    it "has attributes" do
      data = {uid: 12,
              username: "mr_steal_yo_gurl",
              image_url: "https://bit.ly/2tlLmZc",
              spotify_token: "t0k3n"}

      user = User.create(data)

      expect(user.uid).to eq(12)
      expect(user.username).to eq("mr_steal_yo_gurl")
      expect(user.image_url).to eq("https://bit.ly/2tlLmZc")
      expect(user.spotify_token).to eq("t0k3n")
    end
  end
end
