<?php
/**
 * https://neofr.ag
 * @author: Michaël BILCOT <michael.bilcot@neofr.ag>
 */

$this	->rule($this->form_image('cover', 'user/cover')
					->default(image('default_cover.jpg'))
					->rectangle(1920, 400)
		)
		->success(function($profile){
			$profile->commit();
			notify($this->lang('Photo de couverture modifiée'));
			refresh();
		});
