import * as path from 'path';
import { Configuration, LoaderOptionsPlugin } from 'webpack';

const configs: Configuration = {
  target: 'node',
  mode: 'development',
  devtool: 'inline-source-map',
  entry: {
    kinesis_stream_events: './kinesis_stream_events/src/index.ts',
  },
  output: {
    filename: '[name].js',
    path: path.resolve(__dirname, './dist'),
    libraryTarget: 'commonjs2',
    clean: true,
  },
  resolve: {
    mainFields: ['browser', 'main', 'module'],
    extensions: ['.ts', '.js'],
  },
  externals: {
    'aws-sdk': 'aws-sdk',
  },
  module: {
    rules: [
      {
        test: /\.(tsx|ts)?$/,
        exclude: /node_modules/,
        use: [
          {
            loader: 'ts-loader',
            options: {
              transpileOnly: true,
            },
          },
        ],
      },
    ],
  },
  plugins: [
    new LoaderOptionsPlugin({
      debug: false,
    }),
  ],
  bail: true,
};

export default configs;
