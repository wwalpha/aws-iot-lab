json=$(cat <<-END
{
  "lambdaFunction": {
    "lambdaArn": "$LAMBDA_ARN",
    "componentName": "$COMPONENT_NAME",
    "componentVersion": "$COMPONENT_VERSION",
    "componentLambdaParameters": {
      "pinned": true,
      "timeoutInSeconds": 5,
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

# component arn
arn="arn:aws:greengrass:$REGION:$ACCOUNT_ID:components:$COMPONENT_NAME"
# component version list
versions=$(aws greengrassv2 list-component-versions --arn $arn | jq '[.componentVersions[].componentVersion]')

# if version exists
if [[ "${versions[*]}" =~ $COMPONENT_VERSION ]]; then
  # delete version
  aws greengrassv2 delete-component --arn "$arn:versions:$COMPONENT_VERSION"
fi

# create new version
aws greengrassv2 create-component-version --cli-input-json file://lambda_components.json


