while true; do
  if kubectl wait --for=condition=complete --timeout=0 job/kaniko 2>/dev/null; then
    job_result=0
    break
  fi

  if kubectl wait --for=condition=failed --timeout=0 job/kaniko 2>/dev/null; then
    job_result=1
    break
  fi

  sleep 3
done

if [[ $job_result -eq 1 ]]; then
    echo "Job failed!"
    exit 1
fi

echo "Job succeeded"