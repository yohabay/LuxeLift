enum RideStatus {
  pending,
  accepted,
  driverArrived,
  inProgress,
  completed,
  cancelled,
  expired;

  String get displayName {
    switch (this) {
      case RideStatus.pending:
        return 'Pending';
      case RideStatus.accepted:
        return 'Accepted';
      case RideStatus.driverArrived:
        return 'Driver Arrived';
      case RideStatus.inProgress:
        return 'In Progress';
      case RideStatus.completed:
        return 'Completed';
      case RideStatus.cancelled:
        return 'Cancelled';
      case RideStatus.expired:
        return 'Expired';
    }
  }

  String get value {
    switch (this) {
      case RideStatus.pending:
        return 'pending';
      case RideStatus.accepted:
        return 'accepted';
      case RideStatus.driverArrived:
        return 'driver_arrived';
      case RideStatus.inProgress:
        return 'in_progress';
      case RideStatus.completed:
        return 'completed';
      case RideStatus.cancelled:
        return 'cancelled';
      case RideStatus.expired:
        return 'expired';
    }
  }

  static RideStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return RideStatus.pending;
      case 'accepted':
        return RideStatus.accepted;
      case 'driver_arrived':
        return RideStatus.driverArrived;
      case 'in_progress':
        return RideStatus.inProgress;
      case 'completed':
        return RideStatus.completed;
      case 'cancelled':
        return RideStatus.cancelled;
      case 'expired':
        return RideStatus.expired;
      default:
        return RideStatus.pending;
    }
  }
}
