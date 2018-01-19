import React from 'react';
import { expect } from 'chai';
import { mount } from 'enzyme';
import Foo from '../app/Foo';

describe('<Foo />', () => {
  it('calls componentDidMount', () => {
    const wrapper = mount(<Foo />);
    expect(Foo.prototype.componentDidMount.calledOnce).to.equal(true);
  });
});