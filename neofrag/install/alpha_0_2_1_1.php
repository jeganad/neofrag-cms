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

		foreach ($this->db()->select('disposition_id', 'disposition')->from('nf_dispositions')->where('theme', 'azuro')->where('disposition LIKE', '%card-default%')->get() as $disposition)
		{
			$disposition['disposition'] = unserialize($disposition['disposition']);

			$disposition['disposition']->each($f = function($a) use (&$f){
				if (is_a($a, 'NF\NeoFrag\Displayables\Widget'))
				{
					if ($a->style() == 'card-default')
					{
						$a->style('');
					}
				}
				else if ($a)
				{
					$a->each($f);
				}

				return $a;
			});

			$this->db()	->where('disposition_id', $disposition['disposition_id'])
						->update('nf_dispositions', [
							'disposition' => serialize($disposition['disposition'])
						]);
		}
	}
}
