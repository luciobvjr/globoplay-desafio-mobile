const {onCall} = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");
const fetch = require("node-fetch");
require("dotenv").config();

const apiKey = process.env.TMDB_API_KEY;
const baseURL = "https://api.themoviedb.org/3";

if (!apiKey) {
  logger.error("Missing TMDB_API_KEY environment variable");
}

exports.getRecommendations = onCall(
    {
      enforceAppCheck: true,
    }, async (request) => {
      const mediaId = request.data.mediaId;
      const mediaType = request.data.mediaType;

      try {
        // eslint-disable-next-line max-len
        let url = `${baseURL}/${mediaType}/${mediaId}/recommendations?api_key=${apiKey}`;
        url += "&include_adult=false";
        url += "&language=pt-BR";
        logger.info(`Fetching URL: ${url}`);
        const res = await fetch(url);

        if (!res) {
          throw new Error("No response from fetch");
        }

        logger.info(`Response status: ${res.status}`);

        if (!res.ok) {
          throw new Error(`Error fetching recommendations: ${res.statusText}`);
        }

        return await res.json();
      } catch (error) {
        logger.error("Error fetching recommendations", error);
      }
    },
);

exports.getMediaByGenre = onCall(
    {
      enforceAppCheck: true,
    }, async (request) => {
      const genreId = request.data.genreId;
      const mediaType = request.data.mediaType;

      try {
        let url = `${baseURL}/discover/${mediaType}?api_key=${apiKey}`;
        url += `&with_genres=${genreId}`;
        url += "&include_adult=false";
        url += "&language=pt-BR";

        logger.info(`Fetching URL: ${url}`);
        const res = await fetch(url);

        if (!res) {
          throw new Error("No response from fetch");
        }

        logger.info(`Response status: ${res.status}`);

        if (!res.ok) {
          throw new Error(`Error fetching medias: ${res.statusText}`);
        }

        return await res.json();
      } catch (error) {
        logger.error("Error fetching medias", error);
      }
    },
);

exports.searchForMovies = onCall(
    {
      enforceAppCheck: true,
    }, async (request) => {
      const query = request.data.query;

      try {
        const url = `${baseURL}/search/movie?api_key=${apiKey}&query=${query}`;
        logger.info(`Fetching URL: ${url}`);
        const res = await fetch(url);

        if (!res) {
          throw new Error("No response from fetch");
        }

        logger.info(`Response status: ${res.status}`);

        if (!res.ok) {
          throw new Error(`Error fetching movies: ${res.statusText}`);
        }

        return await res.json();
      } catch (error) {
        logger.error("Error fetching movies", error);
      }
    },
);

exports.searchForTVShows = onCall(
    {
      enforceAppCheck: true,
    }, async (request) => {
      const query = request.data.query;

      try {
        const url = `${baseURL}/search/tv?api_key=${apiKey}&query=${query}`;
        logger.info(`Fetching URL: ${url}`);
        const res = await fetch(url);

        if (!res) {
          throw new Error("No response from fetch");
        }

        logger.info(`Response status: ${res.status}`);

        if (!res.ok) {
          throw new Error(`Error fetching movies: ${res.statusText}`);
        }

        return await res.json();
      } catch (error) {
        logger.error("Error fetching movies", error);
      }
    },
);
