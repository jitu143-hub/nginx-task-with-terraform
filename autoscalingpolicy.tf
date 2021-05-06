resource "aws_autoscaling_policy" "scaleup" {
   name = "scaleup"
   autoscaling_group_name = aws_autoscaling_group.test-autoscaling.name
   adjustment_type = "ChangeInCapacity"
   scaling_adjustment = "1"
   cooldown = "300"
   policy_type = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "cpu-alarm-scaleup" {
   alarm_name = "cpu-alarm-scaleup"
   alarm_description = "alert scaleup policy to scale one more ec2instance"
   comparison_operator = "GreaterThanOrEqualToThreshold"
   evaluation_periods =  "2"
   metric_name = "CpuUtilization"
   namespace = "AWS/EC2"
   period = "120"
   statistic = "Average"
   threshold = "30"
   
   dimensions = {
     "AutoScalingGroupName" = aws_autoscaling_group.test-autoscaling.name
	 }
	 actions_enabled = true
	 alarm_actions = [aws_autoscaling_policy.scaleup.arn]
}   
   
resource "aws_autoscaling_policy" "scaledown" {
   name = "scaledown"
   autoscaling_group_name = aws_autoscaling_group.test-autoscaling.name
   adjustment_type = "ChangeInCapacity"
   scaling_adjustment = "-1"
   cooldown = "300"
   policy_type = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "cpu-alarm-scaledown" {
   alarm_name = "cpu-slarm-scaledown"
   alarm_description = "alert scaleup policy to scale down more ec2instance"
   comparison_operator = "GreaterThanOrEqualToThreshold"
   evaluation_periods =  "2"
   metric_name = "CpuUtilization"
   namespace = "AWS/EC2"
   period = "120"
   statistic = "Average"
   threshold = "30"
   
   dimensions = {
     "AutoScalingGroupName" = aws_autoscaling_group.test-autoscaling.name
	 }
	 actions_enabled = true
	 alarm_actions = [aws_autoscaling_policy.scaledown.arn]
}     
   
