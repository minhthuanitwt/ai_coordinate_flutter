# Contract: Coordinate Job Polling and Recovery

## Purpose

Define asynchronous status tracking behavior for generation jobs, including timeout and recovery rules.

## Active Polling Contract

- After submit, app starts job-status polling for each generated output job.
- Job states are represented with stage/status updates until terminal state (`completed` or `failed`) or timeout.
- UI shows in-progress indicators while polling is active.

## Timeout Contract

- Timeout threshold is fixed at 90 seconds for active polling in current view.
- If timeout is reached without terminal status:
  - active polling is stopped for the current screen lifecycle,
  - user sees a "still processing" informational state,
  - job is not treated as failed solely due to timeout.

## Re-entry Recovery Contract

- When user re-enters Coordinate route in same authenticated session:
  - app reloads outstanding in-progress jobs,
  - polling resumes automatically for those jobs,
  - recovered terminal results are merged into gallery without duplicates.

## Failure Contract

- Network/polling errors must present non-blocking feedback and allow recovery retry path.
- Backend-declared failed jobs are shown as failure outcomes and never charged percoin.
