set -o noglob
if [ "$ECS_PARAM_LAUNCH_TYPE" == "FARGATE" ]; then
    echo "Setting --platform-version"
    set -- "$@" --platform-version "$ECS_PARAM_PLATFORM_VERSION"
fi
if [ -n "$ECS_PARAM_STARTED_BY" ]; then
    echo "Setting --started-by"
    set -- "$@" --started-by "$ECS_PARAM_STARTED_BY"
fi
if [ -n "$ECS_PARAM_GROUP" ]; then
    echo "Setting --group"
    set -- "$@" --group "$ECS_PARAM_GROUP"
fi
if [ -n "$ECS_PARAM_OVERRIDES" ]; then
    echo "Setting --overrides"
    set -- "$@" --overrides "$ECS_PARAM_OVERRIDES"
fi
if [ -n "$ECS_PARAM_TAGS" ]; then
    echo "Setting --tags"
    set -- "$@" --tags "$ECS_PARAM_TAGS"
fi
if [ -n "$ECS_PARAM_PLACEMENT_CONSTRAINTS" ]; then
    echo "Setting --placement-constraints"
    set -- "$@" --placement-constraints "$ECS_PARAM_PLACEMENT_CONSTRAINTS"
fi
if [ -n "$ECS_PARAM_PLACEMENT_STRATEGY" ]; then
    echo "Setting --placement-strategy"
    set -- "$@" --placement-strategy "$ECS_PARAM_PLACEMENT_STRATEGY"
fi
if [ "$ECS_PARAM_ENABLE_ECS_MANAGED_TAGS" == "true" ]; then
    echo "Setting --enable-ecs-managed-tags"
    set -- "$@" --enable-ecs-managed-tags
fi
if [ "$ECS_PARAM_ENABLE_ECS_MANAGED_TAGS" == "true" ]; then
    echo "Setting --propagate-tags"
    set -- "$@" --propagate-tags "TASK_DEFINITION"
fi
if [ "$ECS_PARAM_AWSVPC" == "true" ]; then
    echo "Setting --network-configuration"
    set -- "$@" --network-configuration awsvpcConfiguration="{subnets=[$ECS_PARAM_SUBNET_ID],securityGroups=[$ECS_PARAM_SEC_GROUP_ID],assignPublicIp=$ECS_PARAM_ASSIGN_PUB_IP}"
fi

aws ecs run-task \
    --cluster "$ECS_PARAM_CLUSTER" \
    --task-definition "$ECS_PARAM_TASK_DEF" \
    --count "$ECS_PARAM_COUNT" \
    --launch-type "$ECS_PARAM_LAUNCH_TYPE" \
    "$@"