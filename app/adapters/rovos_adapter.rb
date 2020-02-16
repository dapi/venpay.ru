class RovosAdapter < ApplicationAdapter
  def status
    RovosClient.build.post('/machines/' + machine.internal_id.to_s, state: 4)
  rescue Faraday::TimeoutError, Faraday::ClientError, RovosClient::Error => error
    raise ApplicationAdapter::Error, error
  end

  # @param time [Numeric] time to start in minutes
  # @return => {"sent"=>{"header"=>17271, "state"=>2, "work_time"=>10, "time_left"=>0, "machine_id"=>100020003},
  #             "received"=>{"header"=>17271, "state"=>2, "work_time"=>10, "time_left"=>2560, "machine_id"=>100020003}}
  def start(time)
    RovosClient
      .build
      .post('/machines/' + machine.internal_id.to_s,
            state: 2, # Start command
            work_time: time)
    log_success_acitity time
  rescue Faraday::TimeoutError, Faraday::ClientError, RovosClient::Error => err
    log_failed_acivity time, err
    raise ApplicationAdapter::Error, err
  end
end
