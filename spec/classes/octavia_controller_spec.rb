require 'spec_helper'

describe 'octavia::controller' do

  shared_examples_for 'octavia-controller' do

    context 'with invalid lb topology' do
      let :params do
        { :loadbalancer_topology => 'foo', }
      end
      it { is_expected.to raise_error(Puppet::Error) }
    end

    context 'configured with specific parameters' do
      let :params do
        { :amp_flavor_id               => '42',
          :amp_image_tag               => 'amphorae1',
          :amp_secgroup_list           => ['lb-mgmt-sec-grp'],
          :amp_boot_network_list       => ['lbnet1', 'lbnet2'],
          :loadbalancer_topology       => 'SINGLE',
          :amp_ssh_key_name            => 'custom-amphora-key',
          :controller_ip_port_list     => '1.2.3.4:5555,4.3.2.1:5555',
          :connection_max_retries      => 240,
          :connection_retry_interval   => 10,
          :connection_logging         => false,
          :build_active_retries        => 5,
          :port_detach_timeout         => 15,
          :admin_log_targets           => '192.0.2.1:10514,2001:db8:1::10:10514',
          :administrative_log_facility => 2,
          :forward_all_logs            => true,
          :tenant_log_targets          => '192.0.2.1:10514,2001:db8:1::10:10514',
          :user_log_facility           => 3,
          :user_log_format             => '{{ project_id }} {{ lb_id }}',
          :disable_local_log_storage   => true,
          :vrrp_advert_int             => 1,
          :vrrp_check_interval         => 5,
          :vrrp_fail_count             => 2,
          :vrrp_success_count          => 2,
          :vrrp_garp_refresh_interval  => 5,
          :vrrp_garp_refresh_count     => 2,
          :enable_anti_affinity        => true,
          :anti_affinity_policy        => 'anti-affinity'
        }
      end

      it { is_expected.to contain_octavia_config('controller_worker/amp_flavor_id').with_value('42') }
      it { is_expected.to contain_octavia_config('controller_worker/amp_image_tag').with_value('amphorae1') }
      it { is_expected.to contain_octavia_config('controller_worker/amp_secgroup_list').with_value(['lb-mgmt-sec-grp']) }
      it { is_expected.to contain_octavia_config('controller_worker/amp_boot_network_list').with_value(['lbnet1', 'lbnet2']) }
      it { is_expected.to contain_octavia_config('controller_worker/loadbalancer_topology').with_value('SINGLE') }
      it { is_expected.to contain_octavia_config('controller_worker/amp_ssh_key_name').with_value('custom-amphora-key') }
      it { is_expected.to contain_octavia_config('health_manager/controller_ip_port_list').with_value('1.2.3.4:5555,4.3.2.1:5555') }
      it { is_expected.to contain_octavia_config('haproxy_amphora/connection_max_retries').with_value(240) }
      it { is_expected.to contain_octavia_config('haproxy_amphora/connection_retry_interval').with_value(10) }
      it { is_expected.to contain_octavia_config('haproxy_amphora/connection_logging').with_value(false) }
      it { is_expected.to contain_octavia_config('haproxy_amphora/build_active_retries').with_value(5) }
      it { is_expected.to contain_octavia_config('networking/port_detach_timeout').with_value(15) }
      it { is_expected.to contain_octavia_config('amphora_agent/admin_log_targets').with_value('192.0.2.1:10514,2001:db8:1::10:10514') }
      it { is_expected.to contain_octavia_config('amphora_agent/administrative_log_facility').with_value(2) }
      it { is_expected.to contain_octavia_config('amphora_agent/forward_all_logs').with_value(true) }
      it { is_expected.to contain_octavia_config('amphora_agent/tenant_log_targets').with_value('192.0.2.1:10514,2001:db8:1::10:10514') }
      it { is_expected.to contain_octavia_config('amphora_agent/user_log_facility').with_value(3) }
      it { is_expected.to contain_octavia_config('haproxy_amphora/user_log_format').with_value('{{ project_id }} {{ lb_id }}') }
      it { is_expected.to contain_octavia_config('amphora_agent/disable_local_log_storage').with_value(true) }
      it { is_expected.to contain_octavia_config('keepalived_vrrp/vrrp_advert_int').with_value(1) }
      it { is_expected.to contain_octavia_config('keepalived_vrrp/vrrp_check_interval').with_value(5) }
      it { is_expected.to contain_octavia_config('keepalived_vrrp/vrrp_fail_count').with_value(2) }
      it { is_expected.to contain_octavia_config('keepalived_vrrp/vrrp_success_count').with_value(2) }
      it { is_expected.to contain_octavia_config('keepalived_vrrp/vrrp_garp_refresh_interval').with_value(5) }
      it { is_expected.to contain_octavia_config('keepalived_vrrp/vrrp_garp_refresh_count').with_value(2) }
      it { is_expected.to contain_octavia_config('nova/enable_anti_affinity').with_value(true) }
      it { is_expected.to contain_octavia_config('nova/anti_affinity_policy').with_value('anti-affinity') }
    end

    it 'configures worker parameters' do
      is_expected.to contain_octavia_config('controller_worker/amp_flavor_id').with_value('65')
      is_expected.to contain_octavia_config('controller_worker/amphora_driver').with_value('amphora_haproxy_rest_driver')
      is_expected.to contain_octavia_config('controller_worker/compute_driver').with_value('compute_nova_driver')
      is_expected.to contain_octavia_config('controller_worker/network_driver').with_value('allowed_address_pairs_driver')
      is_expected.to contain_octavia_config('controller_worker/amp_ssh_key_name').with_value('octavia-ssh-key')
      is_expected.to contain_octavia_config('haproxy_amphora/timeout_client_data').with_value('<SERVICE DEFAULT>')
      is_expected.to contain_octavia_config('haproxy_amphora/timeout_member_connect').with_value('<SERVICE DEFAULT>')
      is_expected.to contain_octavia_config('haproxy_amphora/timeout_member_data').with_value('<SERVICE DEFAULT>')
      is_expected.to contain_octavia_config('haproxy_amphora/timeout_tcp_inspect').with_value('<SERVICE DEFAULT>')
      is_expected.to contain_octavia_config('haproxy_amphora/connection_max_retries').with_value('<SERVICE DEFAULT>')
      is_expected.to contain_octavia_config('haproxy_amphora/connection_retry_interval').with_value('<SERVICE DEFAULT>')
      is_expected.to contain_octavia_config('haproxy_amphora/connection_logging').with_value('<SERVICE DEFAULT>')
      is_expected.to contain_octavia_config('haproxy_amphora/build_active_retries').with_value('<SERVICE DEFAULT>')
      is_expected.to contain_octavia_config('networking/port_detach_timeout').with_value('<SERVICE DEFAULT>')
      is_expected.to contain_octavia_config('amphora_agent/admin_log_targets').with_value('<SERVICE DEFAULT>')
      is_expected.to contain_octavia_config('amphora_agent/administrative_log_facility').with_value('<SERVICE DEFAULT>')
      is_expected.to contain_octavia_config('amphora_agent/forward_all_logs').with_value('<SERVICE DEFAULT>')
      is_expected.to contain_octavia_config('amphora_agent/tenant_log_targets').with_value('<SERVICE DEFAULT>')
      is_expected.to contain_octavia_config('amphora_agent/user_log_facility').with_value('<SERVICE DEFAULT>')
      is_expected.to contain_octavia_config('haproxy_amphora/user_log_format').with_value('<SERVICE DEFAULT>')
      is_expected.to contain_octavia_config('amphora_agent/disable_local_log_storage').with_value('<SERVICE DEFAULT>')
      is_expected.to contain_octavia_config('keepalived_vrrp/vrrp_advert_int').with_value('<SERVICE DEFAULT>')
      is_expected.to contain_octavia_config('keepalived_vrrp/vrrp_check_interval').with_value('<SERVICE DEFAULT>')
      is_expected.to contain_octavia_config('keepalived_vrrp/vrrp_fail_count').with_value('<SERVICE DEFAULT>')
      is_expected.to contain_octavia_config('keepalived_vrrp/vrrp_success_count').with_value('<SERVICE DEFAULT>')
      is_expected.to contain_octavia_config('keepalived_vrrp/vrrp_garp_refresh_interval').with_value('<SERVICE DEFAULT>')
      is_expected.to contain_octavia_config('keepalived_vrrp/vrrp_garp_refresh_count').with_value('<SERVICE DEFAULT>')
      is_expected.to contain_octavia_config('nova/enable_anti_affinity').with_value('<SERVICE DEFAULT>')
      is_expected.to contain_octavia_config('nova/anti_affinity_policy').with_value('<SERVICE DEFAULT>')
    end

    context 'with ssh key access disabled' do
      let :params do
        { :enable_ssh_access => false }
      end

      it 'disables configuration of SSH key properties' do
        is_expected.to contain_octavia_config('controller_worker/amp_ssh_key_name').with_value('<SERVICE DEFAULT>')
      end
    end

  end

  on_supported_os({
    :supported_os => OSDefaults.get_supported_os
  }).each do |os,facts|
    context "on #{os}" do
      let (:facts) do
        facts.merge!(OSDefaults.get_facts())
      end
      it_behaves_like 'octavia-controller'
    end
  end

end
