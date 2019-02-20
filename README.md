# TuneView [![Build Status](https://travis-ci.org/cebarks/TuneView.svg?branch=master)](https://travis-ci.org/cebarks/TuneView)
### Pitch

TuneView is a unique way to learn more about yourself and the way you listen to music.

### Problem

Users often sacrifice personalization for prebuilt playlists or complicated features that may never be used.
Availability of lyrics is limited to select tracks.

### Solution

Tuneview simplifies the process of viewing interesting stats about your music preferences.

<img width="1440" alt="tuneviewplaylist" src="https://user-images.githubusercontent.com/40776966/53116163-36ae1e00-3505-11e9-9db3-7a5025f71771.png">

### Target Audience

Any users of Spotify who want to explore music in a simple view and be able to view the lyrics.

### Integrations

- Spotify: OAuth, several endpoints
- LastFM: artist bios and similar artists
- MusicXMatch: song lyrics

## Local Setup

Clone down the repo
```
$ git clone git@github.com:cebarks/TuneView.git
```

Install the gem packages
```
$ bundle
```

Set up the database
```
$ rake db:{create,migrate,seed}
```

Run the test suite:
```
$ rspec
```

## API Setup
We need to run Figaro to create a hidden .yml file to store our API keys locally

```
$ bundle exec figaro install
```

## Within config/application.yml, add the following Environment Variable keys:

# Discogs
* Request_Token_URL:	    https://api.discogs.com/oauth/request_token
* Authorize_URL:          https://www.discogs.com/oauth/authorize
* Access_Token_URL:	      https://api.discogs.com/oauth/access_token

# Spotify
* SPOTIFY_CLIENT_ID:	    `your id from spotify`
* SPOTIFY_CLIENT_SECRET:	`your client secret from spotify`
* S_TEST_TOKEN:           `token from spotify`
* REQUEST_TOKEN:          `refresh token from spotify`

* S_TEST_USERNAME:       `spotify username`
* S_TEST_IMAGE_URL:      `https://bit.ly/2tlLmZc`
* S_TEST_PROFILE_URL:    `https://open.spotify.com/user/(your spotify username)`

## Contributors

* Anton   [https://github.com/cebarks](https://github.com/cebarks)
* Nico    [https://github.com/nicovigil1](https://github.com/nicovigil1)
* Michael [https://github.com/SyntheticAutomation](https://github.com/SyntheticAutomation)
* Aaron   [https://github.com/abroberts5](https://github.com/abroberts5)

## Deployment

Our app is deployed on heroku at:

* [http://tuneview.herokuapp.com](http://http://tuneview.herokuapp.com/)

## Technologies
* [vcr](https://github.com/vcr/vcr)

### Versions
* Ruby 2.5.3
* Rails 5.2.0
