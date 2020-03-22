<?php
/**
 * https://neofr.ag
 * @author: Michaël BILCOT <michael.bilcot@neofr.ag>
 */

namespace NF\NeoFrag\Install;

use NF\NeoFrag\Loadables\Install;

class Alpha_0_2_1_1 extends Install
{
	public function up()
	{
		$this->config('nf_registration_status', !$this->nf_registration_status, 'bool');

		$this->db	->execute('ALTER TABLE `neofrag`.`nf_user` DROP INDEX `username`, ADD INDEX `username` (`username`) USING BTREE')
					->execute('ALTER TABLE `neofrag`.`nf_user` DROP INDEX `email`, ADD INDEX `email` (`email`) USING BTREE');
	}
}
