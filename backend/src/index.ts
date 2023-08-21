import express from "express";
import { ApolloServer } from "@apollo/server";
import { expressMiddleware } from "@apollo/server/express4";

async function init() {
  const app = express();

  const PORT = process.env.PORT || 8000;

  app.use(express.json());

  const server = new ApolloServer({
    typeDefs: `
        type Query{
            hello:String
        }
    `,
    resolvers: {
      Query: {
        hello: () => `Hey, I am graphql server`,
      },
    },
  });

  await server.start();

  app.get("/", (req, res) => {
    res.json({ message: "server is up and running" });
  });

  app.use("/graphql", expressMiddleware(server));

  app.listen(PORT, () => console.log(`server is running on port ${PORT}`));
}
init();
