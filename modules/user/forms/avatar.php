<?php
/**
 * https://neofr.ag
 * @author: Michaël BILCOT <michael.bilcot@neofr.ag>
 */

$this	->rule($this->form_image('avatar', 'user/avatar')
					->default(image($this->model()->sex == 'female' ? 'default_avatar_female.jpg' : 'default_avatar_male.jpg'))
					->square(250)
		)
		->success(function($data){
			$profile->commit();
			notify($this->lang('Avatar modifié'));
			refresh();
		});
