json=$(cat <<-END
{
  "lambdaFunction": {
    "lambdaArn": "$LAMBDA_ARN",
    "componentName": "$COPOMNENT_NAME",
    "componentVersion": "$COPOMNENT_VERSION",
    "componentLambdaParameters": {
      "eventSources": [
        {
          "topic": "$EVENT_TOPIC",
          "type": "$EVENT_TYPE"
        }
      ],
      "linuxProcessParams": {
        "isolationMode": "NoContainer"
      }
    }
  }
}
END
)

echo $json > lambda_components.json

aws greengrassv2 create-component-version --cli-input-json file://lambda_components.json