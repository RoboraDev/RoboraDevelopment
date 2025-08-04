import rclpy
from rclpy.node import Node

class BasicNode(Node):
    def __init__(self):
        super().__init__('basic_node')
        self.get_logger().info('Robora basic ROS2 node running!')

def main(args=None):
    rclpy.init(args=args)
    node = BasicNode()
    rclpy.spin(node)
    rclpy.shutdown()

if __name__ == '__main__':
    main()
