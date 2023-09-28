

// Print all running transactions
SHOW TRANSACTIONS
YIELD transactionId, elapsedTime, cpuTime, waitTime, idleTime,
  currentQueryElapsedTime, currentQueryCpuTime, currentQueryWaitTime, currentQueryIdleTime
RETURN
  transactionId AS txId,
  elapsedTime.milliseconds AS elapsedTimeMillis,
  cpuTime.milliseconds AS cpuTimeMillis,
  waitTime.milliseconds AS waitTimeMillis,
  idleTime.seconds AS idleTimeSeconds,
  currentQueryElapsedTime.milliseconds AS currentQueryElapsedTimeMillis,
  currentQueryCpuTime.milliseconds AS currentQueryCpuTimeMillis,
  currentQueryWaitTime.microseconds AS currentQueryWaitTimeMicros,
  currentQueryIdleTime.seconds AS currentQueryIdleTimeSeconds;
  